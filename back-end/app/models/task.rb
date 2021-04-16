class Task < ActiveRecord::Base
    belongs_to :category

    def self.return_all
        includes(:category).all.map { |t| { id: t.id, text: t.text, category: t.category.name } }
    end
end
