require 'rails_helper'

describe Subscription do
	let(:author) {FactoryGirl.create(:user)}
	let(:subscriber) {FactoryGirl.create(:user)}
	let(:subscription) {subscriber.subscriptions.build(author_id: author.id)}

	subject {subscription}
	it {should be_valid}

	describe 'follower methods' do
		it { should respond_to(:author)}
		it { should respond_to(:subscriber)}
	end
end
