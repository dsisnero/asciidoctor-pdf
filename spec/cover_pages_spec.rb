require_relative 'spec_helper'

describe 'Asciidoctor::PDF::Converter - Cover Pages' do
  it 'should add front cover page if front-cover-image is set' do
    pdf = to_pdf <<~'EOS', attributes: { 'imagesdir' => fixtures_dir }, analyze: true
    = Document Title
    :doctype: book
    :front-cover-image: image:cover.jpg[]

    content page
    EOS

    (expect pdf.pages.size).to eql 3
    (expect pdf.pages[0][:text]).to be_empty
  end

  it 'should scale front cover image to fit width of page', integration: true do
    to_file = to_pdf_file <<~'EOS', 'cover-pages-front-cover.pdf', attributes: { 'imagesdir' => fixtures_dir }
    = Document Title
    :doctype: book
    :front-cover-image: image:cover.jpg[]

    content page
    EOS

    (expect to_file).to visually_match 'cover-pages-front-cover.pdf'
  end
end