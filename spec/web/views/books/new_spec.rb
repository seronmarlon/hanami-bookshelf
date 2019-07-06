RSpec.describe Web::Views::Books::New, type: :view do
  it 'exposes #format' do
    exposures = Hash[format: :html]
    template = Hanami::View::Template.new('apps/web/templates/books/new.html.erb')
    view = described_class.new(template, exposures)

    expect(view.format).to eq exposures.fetch(:format)
  end

  it 'displays list of errors when params contains errors' do
    params = OpenStruct.new(valid?: false, error_messages: ['Title must be filled', 'Author must be filled'])
    exposures = Hash[params: params]
    template = Hanami::View::Template.new('apps/web/templates/books/new.html.erb')
    view = described_class.new(template, exposures)

    rendered = view.render

    expect(rendered).to include('There was a problem with your submission')
    expect(rendered).to include('Title must be filled')
    expect(rendered).to include('Author must be filled')
  end
end
