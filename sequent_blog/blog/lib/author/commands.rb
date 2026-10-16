# frozen_string_literal: true

class AddAuthor < Sequent::Command
  attrs name: String, email: String
  validates_presence_of :name, :email
end

