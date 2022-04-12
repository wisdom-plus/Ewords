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

  def self.random_record_ids(level, num)
    where(level: level).pluck(:id).sample(num)
  end

  def self.answer_ids(level)
    random_record_ids(level, QUESTION_NUM)
  end

  def self.except_records(answer_id, level)
    n = CHOICE_NUM - 1
    where.not(id: answer_id).where(level: level).sample(n)
  end

  def self.choices(answer_record)
    choices = except_records(answer_record.id, answer_recored.level)
    choices.push(answer_record).shuffle
  end
end
