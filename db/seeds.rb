# frozen_string_literal: true

require 'faker'

# Устанавливаем русскую локаль
Faker::Config.locale = :ru

# Создаем категории
categories_data = [
  { name: 'Программирование' },
  { name: 'Жизнь' },
  { name: 'Путешествия' }
]

categories = categories_data.map do |category_attrs|
  Category.find_or_create_by!(name: category_attrs[:name])
end

# Создаем тестовых пользователей
user = User.find_or_create_by!(email: 'test@example.org') do |u|
  u.password = 'password'
  u.password_confirmation = 'password'
end

user2 = User.find_or_create_by!(email: 'test2@example.org') do |u|
  u.password = 'password'
  u.password_confirmation = 'password'
end

# Создаем тестовые посты с русским Faker
posts = [
  {
    title: 'Что такое динамическое программирование',
    body: Faker::Lorem.paragraph_by_chars(number: 500),
    category: categories[1],
    creator: user2
  },
  {
    title: 'Что такое криптография?',
    body: Faker::Lorem.paragraph_by_chars(number: 500),
    category: categories[0],
    creator: user
  }
]

# Добавляем дополнительные посты через Faker с русским текстом
10.times do
  posts << {
    title: Faker::Lorem.sentence(word_count: rand(3..8)).chomp('.'),
    body: Faker::Lorem.paragraph_by_chars(number: rand(300..800)),
    category: categories.sample,
    creator: [user, user2].sample
  }
end

posts.each do |post_attrs|
  Post.find_or_create_by!(title: post_attrs[:title]) do |post|
    post.body = post_attrs[:body]
    post.category = post_attrs[:category]
    post.creator = post_attrs[:creator]
  end
end

Rails.logger.debug 'Seed data created successfully!'
