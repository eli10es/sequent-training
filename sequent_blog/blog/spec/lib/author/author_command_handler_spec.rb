require_relative '../../spec_helper'
require_relative '../../../lib/author'

describe AuthorCommandHandler do
  before :each do
    Sequent.configuration.command_handlers = [AuthorCommandHandler.new]
  end

  context AddAuthor do
    let(:user_aggregate_id) { Sequent.new_uuid }
    let(:email) { 'ben@sequent.io' }

    it 'creates a user when valid input' do
      when_command AddAuthor.new(aggregate_id: user_aggregate_id, name: 'Ben', email: email)
      then_events AuthorAdded.new(aggregate_id: user_aggregate_id, sequence_number: 1, name: 'Ben', email: email),
                  AuthorNameSet.new(aggregate_id: user_aggregate_id, sequence_number: 2, name: 'Ben'),
                  AuthorEmailSet.new(aggregate_id: user_aggregate_id, email: 'ben@sequent.io', sequence_number: 3)
    end
    it 'fails if the username already exists' do
      given_events AuthorAdded.new(aggregate_id: user_aggregate_id, sequence_number: 1),
                   AuthorNameSet.new(aggregate_id: user_aggregate_id, sequence_number: 2, name: 'Ben'),
                   AuthorEmailSet.new(aggregate_id: user_aggregate_id, sequence_number: 3, email: 'ben@sequent.io')
      expect {
        when_command AddAuthor.new(
          aggregate_id: Sequent.new_uuid,
          name: 'kim',
          email: 'ben@sequent.io'
        )
      }.to raise_error Sequent::Core::AggregateKeyNotUniqueError
    end

    it 'ignores case in usernames' do
      given_events AuthorAdded.new(aggregate_id: user_aggregate_id, sequence_number: 1),
                   AuthorNameSet.new(aggregate_id: user_aggregate_id, sequence_number: 2, name: 'Ben'),
                   AuthorEmailSet.new(aggregate_id: user_aggregate_id, sequence_number: 3, email: 'ben@sequent.io')
      expect {
        when_command AddAuthor.new(
          aggregate_id: Sequent.new_uuid,
          name: 'kim',
          email: 'BeN@SeQuEnT.io'
        )
      }.to raise_error Sequent::Core::AggregateKeyNotUniqueError
    end

  end

end
