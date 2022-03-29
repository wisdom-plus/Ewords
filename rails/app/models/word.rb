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
end
