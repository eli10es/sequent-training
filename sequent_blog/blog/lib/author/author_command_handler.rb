# frozen_string_literal: true

class AuthorCommandHandler < Sequent::CommandHandler
  on AddAuthor do |command|
    repository.add_aggregate Author.new(command)
  end
end
