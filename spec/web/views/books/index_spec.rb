RSpec.describe Web::Views::Books::Index do
  it 'exposes #books' do
    exposures = Hash[books: []]
    template = Hanami::View::Template.new('apps/web/templates/books/index.html.erb')
    view = described_class.new(template, exposures)

    expect(view.books).to eq(exposures.fetch(:books))
  end

  context 'when there are no books' do
    it 'shows a placeholder message' do
      exposures = Hash[books: []]
      template = Hanami::View::Template.new('apps/web/templates/books/index.html.erb')
      view = described_class.new(template, exposures)

      expect(view.render).to include('<p class="placeholder">There are no books yet.</p>')
    end
  end

  context 'when there are books' do
    it 'lists them all' do
      book1 = Book.new(title: 'Refactoring', author: 'Martin Fowler')
      book2 = Book.new(title: 'Domain Driven Design', author: 'Eric Evans')
      exposures = Hash[books: [book1, book2]]
      template = Hanami::View::Template.new('apps/web/templates/books/index.html.erb')
      view = described_class.new(template, exposures)

      rendered = view.render

      expect(rendered.scan(/class="book"/).length).to eq(2)
      expect(rendered).to include(book1.title)
      expect(rendered).to include(book2.title)
    end

    it 'hides the placeholder message' do
      book = Book.new(title: 'Refactoring', author: 'Martin Fowler')
      exposures = Hash[books: [book]]
      template = Hanami::View::Template.new('apps/web/templates/books/index.html.erb')
      view = described_class.new(template, exposures)

      rendered = view.render

      expect(rendered).to_not include('<p class="placeholder">There are no books yet.</p>')
    end
  end
end
