ActiveAdmin.register SkillRequest do
  menu :label => "Zadosti", :parent => 'Uzivatele'

  scope :all, :default => true
  ['opened', 'scheduled', 'closed'].each do |status|
    scope status.to_sym do |request|
      request.where("state = ?", status)
    end
  end

  sidebar 'Invited Contractors', :only => :show do
    render :partial => 'form'
  end

  sidebar 'Bids' do

  end
end
