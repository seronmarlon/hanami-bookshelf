RSpec.describe Web::Controllers::Books::Create do
  context 'with valid params' do
    it 'calls interactor' do
      interactor = instance_double('AddBook', call: nil)
      params = Hash[book: { title: '1984', author: 'George Orwell' }]
      action = described_class.new(interactor: interactor)

      expect(interactor).to receive(:call)
      action.call(params)
    end

    it 'redirects the user to the books listing' do
      interactor = instance_double('AddBook', call: nil)
      params = Hash[book: { title: '1984', author: 'George Orwell' }]
      action = described_class.new(interactor: interactor)

      response = action.call(params)

      expect(response[0]).to eq(302)
      expect(response[1]['Location']).to eq('/books')
    end
  end

  context 'with invalid params' do
    it 'does not call interactor' do
      interactor = instance_double('AddBook', call: nil)
      params = Hash[book: {}]
      action = described_class.new(interactor: interactor)

      expect(interactor).to_not receive(:call)
      action.call(params)
    end

    it 're-renders the books#new view' do
      interactor = instance_double('AddBook', call: nil)
      params = Hash[book: {}]
      action = described_class.new(interactor: interactor)

      response = action.call(params)

      expect(response[0]).to eq(422)
    end

    it 'sets errors attribute accordingly' do
      interactor = instance_double('AddBook', call: nil)
      params = Hash[book: {}]
      action = described_class.new(interactor: interactor)

      action.call(params)

      expect(action.params.errors[:book][:title]).to eq(['is missing'])
      expect(action.params.errors[:book][:author]).to eq(['is missing'])
    end
  end
end
