# frozen_string_literal: true

class Author < Sequent::AggregateRoot

  attr_reader :email
  unique_key :author_email, email: ->{email&.downcase}

  def initialize(command)
    super(command.aggregate_id)
    apply AuthorAdded
    apply AuthorNameSet, name: command.name
    apply AuthorEmailSet, email: command.email
  end

  on AuthorAdded do
  end

  on AuthorEmailSet do |event|
    @email = event.email
  end
end
