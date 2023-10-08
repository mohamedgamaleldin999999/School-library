require 'securerandom'
require_relative 'nameable'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'
require_relative 'rental'
class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission = true)
    super()
    @id = generate_uuid_as_hexadecimal
    @rentals = []
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def add_rental(book)
    Rental.new(book, self)
  end

  def can_use_services?
    of_age || @parent_permission
  end

  def correct_name
    @name
  end

  # Methods triggered by user
  def self.list_all_people(people)
    system 'clear'
    puts 'List of all people: '
    puts ''
    people.each { |person| puts person.name }
  end

  private

  def generate_uuid_as_hexadecimal
    uuid = SecureRandom.uuid
    uuid.gsub('-', '').to_i(16)
  end

  def of_age?(age)
    age >= 18
  end
end
