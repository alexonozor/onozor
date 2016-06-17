require "rails_helper"

RSpec.describe NewsLetter, type: :mailer do
  describe "deliver_letter" do
    let(:mail) { NewsLetter.deliver_letter }

    it "renders the headers" do
      expect(mail.subject).to eq("Deliver letter")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
