RSpec.describe Web::Controllers::Books::Create do
  context 'with valid params' do
    it 'creates a new book' do
      action = described_class.new
      params = Hash[book: { title: 'Confident Ruby', author: 'Avdi Grimm' }]
      repository = BookRepository.new
      repository.clear

      action.call(params)
      book = repository.last

      expect(book.id).to_not be_nil
    end

    it 'redirects the user to the books listing' do
      action = described_class.new
      params = Hash[book: { title: 'Confident Ruby', author: 'Avdi Grimm' }]
      repository = BookRepository.new
      repository.clear

      response = action.call(params)

      expect(response[0]).to eq(302)
      expect(response[1]['Location']).to eq('/books')
    end
  end

  context 'with invalid params' do
    it 'returns HTTP client error' do
      action = described_class.new
      params = Hash[book: {}]

      response = action.call(params)

      expect(response[0]).to eq(422)
    end

    it 'dumps errors in params' do
      action = described_class.new
      params = Hash[book: {}]
      action.call(params)
      errors = action.params.errors

      expect(errors.dig(:book, :title)).to eq(['is missing'])
      expect(errors.dig(:book, :author)).to eq(['is missing'])
    end
  end
end
