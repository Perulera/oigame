FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
  factory :campaign do
    sequence(:name) { |n| "Obliga al estado a testear sus propuestos #{n}" }
    intro 'No puede ser, esto es no puede continuar asi. La situacion es critica, no puede ser que los desarrolladores useamos test par intentar minimizar los bugs en produccion y que en contra el gobierno no tenga ni siquiera un servidor de staging.'
    image { File.open(File.join(Rails.root, '/spec/fixtures/image.jpg')) }
    body 'Se acabo la situacion de precariedad'
    ttype 'fax'
    duedate_at 10.days.from_now
    user { create :user }
  end
end
