# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# Патчим фикстуры ДО их загрузки
module FixturePatch
  # Перехватываем чтение YAML файлов
  def read_fixture_file(path)
    content = super

    # Если это файл posts.yml, post_comments.yml или post_likes.yml
    if path.to_s.include?("posts.yml") ||
       path.to_s.include?("post_comments.yml") ||
       path.to_s.include?("post_likes.yml")

      # Заменяем 'creator:' на 'user_id:' во всем файле
      content = content.gsub("creator:", "user_id:")
    end

    content
  end
end

# Применяем патч
class ActiveRecord::FixtureSet
  prepend FixturePatch
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    include Devise::Test::IntegrationHelpers
  end
end
