# -*- encoding : utf-8 -*-
class SkillTag < ActiveRecord::Base

  field :name, :type => :string
  field :wiki, :type => :text
  field :synonym

  acts_as_taggable_on :synonyms

  #before_create :set_default_synonym

  def set_default_synonym
    self.synonym_list = normalize_tag(self.name)
  end

  def synonym_list=(list = '')
    @synonym_list = (list.split(',').map { |r| r.parameterize(' ').strip } + list.split(',').map { |r| r.strip }).uniq
  end


  def normalize_tag(tag)
    tag.parameterize
  end

  def self.named_like_any(tags, options = {})
    tag_list = ActsAsTaggableOn::TagList.from(tags)
    empty_result = scoped(:conditions => "1 = 0")

    return empty_result if tag_list.empty?

    joins = []
    conditions = []

    context = options.delete(:on)
    owned_by = options.delete(:owned_by)
    alias_base_name = undecorated_table_name.gsub('.', '_')

    if options.delete(:exclude)
      tags_conditions = tag_list.map { |t| sanitize_sql(["#{ActsAsTaggableOn::Tag.table_name}.name #{like_operator} ?", t]) }.join(" OR ")
      conditions << "#{table_name}.#{primary_key} NOT IN (SELECT #{ActsAsTaggableOn::Tagging.table_name}.taggable_id FROM #{ActsAsTaggableOn::Tagging.table_name} JOIN #{ActsAsTaggableOn::Tag.table_name} ON #{ActsAsTaggableOn::Tagging.table_name}.tag_id = #{ActsAsTaggableOn::Tag.table_name}.#{ActsAsTaggableOn::Tag.primary_key} AND (#{tags_conditions}) WHERE #{ActsAsTaggableOn::Tagging.table_name}.taggable_type = #{quote_value(base_class.name)})"

    elsif options.delete(:any)
      # get tags, drop out if nothing returned (we need at least one)
      tags = ActsAsTaggableOn::Tag.named_like_any(tag_list)
      return scoped(:conditions => "1 = 0") unless tags.length > 0

      # setup taggings alias so we can chain, ex: items_locations_taggings_awesome_cool_123
      # avoid ambiguous column name
      taggings_context = context ? "_#{context}" : ''

      #TODO: fix alias to be smaller
      taggings_alias = "#{alias_base_name}#{taggings_context}_taggings_#{tags.map(&:safe_name).join('_')}_#{rand(1024)}"

      tagging_join = "JOIN #{ActsAsTaggableOn::Tagging.table_name} #{taggings_alias}" +
          "  ON #{taggings_alias}.taggable_id = #{table_name}.#{primary_key}" +
          " AND #{taggings_alias}.taggable_type = #{quote_value(base_class.name)}"
      tagging_join << " AND " + sanitize_sql(["#{taggings_alias}.context = ?", context.to_s]) if context

      # don't need to sanitize sql, map all ids and join with OR logic
      conditions << tags.map { |t| "#{taggings_alias}.tag_id = #{t.id}" }.join(" OR ")
      select_clause = "DISTINCT #{table_name}.*" unless context and tag_types.one?

      joins << tagging_join

    else
      tags = ActsAsTaggableOn::Tag.named_any(tag_list)
      return empty_result unless tags.length == tag_list.length

      tags.each do |tag|
        prefix = "#{tag.safe_name}_#{rand(1024)}"

        taggings_alias = "#{alias_base_name}_taggings_#{prefix}"

        tagging_join = "JOIN #{ActsAsTaggableOn::Tagging.table_name} #{taggings_alias}" +
            "  ON #{taggings_alias}.taggable_id = #{table_name}.#{primary_key}" +
            " AND #{taggings_alias}.taggable_type = #{quote_value(base_class.name)}" +
            " AND #{taggings_alias}.tag_id = #{tag.id}"
        tagging_join << " AND " + sanitize_sql(["#{taggings_alias}.context = ?", context.to_s]) if context

        if owned_by
          tagging_join << " AND " +
              sanitize_sql([
                               "#{taggings_alias}.tagger_id = ? AND #{taggings_alias}.tagger_type = ?",
                               owned_by.id,
                               owned_by.class.to_s
                           ])
        end

        joins << tagging_join
      end
    end

    taggings_alias, tags_alias = "#{alias_base_name}_taggings_group", "#{alias_base_name}_tags_group"

    if options.delete(:match_all)
      joins << "LEFT OUTER JOIN #{ActsAsTaggableOn::Tagging.table_name} #{taggings_alias}" +
          "  ON #{taggings_alias}.taggable_id = #{table_name}.#{primary_key}" +
          " AND #{taggings_alias}.taggable_type = #{quote_value(base_class.name)}"


      group_columns = ActsAsTaggableOn::Tag.using_postgresql? ? grouped_column_names_for(self) : "#{table_name}.#{primary_key}"
      group = "#{group_columns} HAVING COUNT(#{taggings_alias}.taggable_id) = #{tags.size}"
    end

    scoped(:select => select_clause,
           :joins => joins.join(" "),
           :group => group,
           :conditions => conditions.join(" AND "),
           :order => options[:order],
           :readonly => false)
  end

end

SkillTag.auto_upgrade!
