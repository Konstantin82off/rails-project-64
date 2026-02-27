# db/seeds.rb
# frozen_string_literal: true

# Создаем категории
categories = Category.create!([
  { name: 'Программирование' },
  { name: 'Жизнь' },
  { name: 'Путешествия' }
])

# Создаем тестового пользователя, если его нет
user = User.find_or_create_by!(email: 'test@example.org') do |u|
  u.password = 'password'
  u.password_confirmation = 'password'
  u.name = 'Test User'
end

# Создаем тестовые посты
posts = [
  {
    title: 'Что такое криптография?',
    body: 'Это может быть не очевидно, но мы сталкиваемся с криптографией каждый день. Например, когда мы оплачиваем покупки картой, смотрим видео на YouTube или заправляем машину, криптография защищает нашу информацию. Может показаться, что криптография – это удел разработчиков, хакеров и корпораций, а про...',
    category: categories.first,
    user: user
  },
  {
    title: 'Что такое динамическое программирование',
    body: 'Работу разработчика часто можно сравнить с решением головоломок. Как в настоящей головоломке, разработчику приходится тратить существенные ресурсы не столько на реализацию конкретного решения, сколько на выбор оптимального подхода. Иногда задача решается легко и эффективно, а порой — только полны...',
    category: categories.second,
    user: user
  }
]

posts.each do |post_attrs|
  Post.find_or_create_by!(title: post_attrs[:title]) do |post|
    post.body = post_attrs[:body]
    post.category = post_attrs[:category]
    post.user = post_attrs[:user]
  end
end

Rails.logger.debug "Seed data created successfully!"
