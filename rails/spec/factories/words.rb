# == Schema Information
#
# Table name: words
#
#  id         :bigint           not null, primary key
#  kind       :integer          default("nan"), not null
#  level      :integer          default("primer"), not null
#  reading    :text             not null
#  word       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :word do
    sequence(:word) {|n| "test#{n}"}
    sequence(:reading) { |n| "テスト#{n}" }
    level { 1 }
    kind { 1 }
  end
end
