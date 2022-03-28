# == Schema Information
#
# Table name: words
#
#  id         :bigint           not null, primary key
#  kind       :integer          default(0), not null
#  level      :integer          default(0), not null
#  reading    :text             not null
#  word       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :word do
    word { 'test' }
    reading { 'テスト' }
    level { 1 }
    kind { 1 }
  end
end
