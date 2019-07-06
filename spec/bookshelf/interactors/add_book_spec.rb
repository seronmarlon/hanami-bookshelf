RSpec.describe AddBook do
  context "good input" do
    it "succeeds" do
      interactor = AddBook.new
      attributes = Hash[author: "James Baldwin", title: "The Fire Next Time"]

      result = interactor.call(attributes)

      expect(result.successful?).to be(true)
    end

    it "creates a Book with correct title and author" do
      interactor = AddBook.new
      attributes = Hash[author: "James Baldwin", title: "The Fire Next Time"]

      result = interactor.call(attributes)

      expect(result.book.title).to eq("The Fire Next Time")
      expect(result.book.author).to eq("James Baldwin")
    end
  end

  context "persistence" do
    it "persists the Book" do
      attributes = Hash[author: "James Baldwin", title: "The Fire Next Time"]
      repository = instance_double("BookRepository")
      expect(repository).to receive(:create)

      AddBook.new(repository: repository).call(attributes)
    end
  end

  context "sending email" do
    it "send :deliver to the mailer" do
      attributes = Hash[author: "James Baldwin", title: "The Fire Next Time"]
      mailer = instance_double("Mailers::BookAddedNotification")
      expect(mailer).to receive(:deliver)

      AddBook.new(mailer: mailer).call(attributes)
    end
  end
end
