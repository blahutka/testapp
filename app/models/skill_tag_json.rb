require "representable/json"
class SkillTagJson
  include Representable::JSON
  
  representable_property :wiki
end