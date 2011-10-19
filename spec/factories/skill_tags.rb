# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :skill_tag do
    name 'zedník'

    factory :skill_tags do
      after_create do
        {'zedník' => {:syn => 'zednik, cihla', :wiki => 'Čtení a použití technických podkladů.'},
         'malíř' => {:syn => 'malíř, natěrač', :wiki => 'Příprava a nanášení dekorativních maleb a nátěrů nebo natírání materiálů tak, aby vytvořily dekorativní efekty.'},
         'obkladač' => {:syn => 'dlaždič, kachlička, obkladač, dlaždice', :wiki => 'Osazování dvířek, dilatačních a ukončovacích lišt ap.'},
         'instalatér' => {:syn => 'instalatér, trubky, topení, vodovod, voda'},
         'vodnář' => {:syn => 'vodnář, trubky, voda, vodovod'},
         'topenář' => {:syn => 'topenář, topení, trubky', :wiki => 'Izolatérské práce na potrubí a armaturách dle příslušných předpisů.'},
         'uklízečka' => {:syn => 'uklízečka, uklid, péče'},
         'architekt' => {:syn => 'architekt, dům, plány,'},
         'zahradník' => {:syn => 'zahradník, tráva, stromy, stříhat, keře, park'},
         'zahradni architekt' => {:syn => 'zahradní architekt, plány, zahrada, park, keře, stromy, trávník'}
        }.each do |key, values|

          FactoryGirl.create(:skill_tag, :name => key, :synonym_list => values[:syn], :wiki => values[:wiki])
        end
      end
    end
  end


end
