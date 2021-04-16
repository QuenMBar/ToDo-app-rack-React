puts 'Clearing old data...'
Category.destroy_all
Task.destroy_all

puts 'Seeding Categories...'

Category.create(name: 'Code')
Category.create(name: 'Food')
Category.create(name: 'Money')
Category.create(name: 'Misc')

puts 'Seeding tasks...'

25.times { Task.create(text: Faker::Lorem.sentence, category_id: Category.all.sample.id) }

puts 'Done!'
