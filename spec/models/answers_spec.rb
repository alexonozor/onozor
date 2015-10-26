require "rails_helper"

# validates_presence_of :body, :question_id, :user_id

RSpec.describe Answer, type: :model do
	let(:old_answer) { create(:answer) }
	let(:answer) { build(:answer) }

	context "Validate the answer object" do
		it ' valid if body, question_id and user_id are  present' do 
			expect(answer).to be_valid
		end

		it 'invalid if body is absent' do
			answer.body = nil
			expect(answer).to be_invalid
		end

		it 'invalid if question_id is absent' do
			answer.question_id = nil
			expect(answer).to be_invalid
		end

		it 'invalid if user_id is absent' do 
			answer.user_id = nil
			expect(answer).to be_invalid
		end

		it 'validates uniqueness of body' do 
			# answer.assign_attributes({ body: old_answer.body, question_id: old_answer.question_id })
			expect(answer).to be_valid
		end

		it 'invalidates if body is not unique across duplicate questions' do 
			answer.assign_attributes( { body: old_answer.body, question_id: old_answer.question_id} )
			expect(answer).to be_invalid
		end


	end
end