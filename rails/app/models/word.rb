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
class Word < ApplicationRecord
  enum level: { primer: 0, basic: 1, abvance: 2, abbreviation: 3, initial: 4 }
  enum kind: { nan: 0, '名詞': 1, '動詞': 2, '副詞': 3, '形容詞': 4, '前置詞': 5, '代名詞': 6, '略語': 7, '頭文字': 8 }

  QUESTION_NUM = 10
  CHOICE_NUM = 4

  def self.random_record(level,num)
    ids = where(level: level).pluck(:id).sample(num)
    where(id: ids)
  end

  def self.answer(level)
    self.random_record(level,QUESTION_NUM)
  end

  def self.except_record(records,level)
    n = records.length * (CHOICE_NUM - 1)
    where.not(id: records.ids).where(level: level).sample(n)
  end

  def self.choices(answer_record,level)
    miss_option = except_record(answer_record,level)
    choices = []

    QUESTION_NUM.times do |n|
      arr = miss_option[n..(n+2)].push(answer_record[n]).shuffle
      choices.push(arr)
    end
    choices
  end
end
