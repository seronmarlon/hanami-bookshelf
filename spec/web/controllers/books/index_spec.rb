RSpec.describe Web::Controllers::Books::Index do
  it 'is successful' do
    response = described_class.new.call(Hash[])

    expect(response[0]).to eq(200)
  end

  it 'exposes all books' do
    action = described_class.new
    params =  Hash[]
    repository = BookRepository.new
    repository.clear

    book = repository.create(title: 'TDD', author: 'Kent Beck')
    action.call(params)

    expect(action.exposures[:books]).to eq([book])
  end
end
