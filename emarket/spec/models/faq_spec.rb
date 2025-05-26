require 'rails_helper'

RSpec.describe Faq, type: :model do
  it "non è valido senza domanda" do
    faq = Faq.new(domanda: nil, risposta: "Solo risposta")
    expect(faq).not_to be_valid
  end

  it "è valido con domanda e risposta" do
    faq = Faq.new(domanda: "Domanda?", risposta: "Risposta")
    expect(faq).to be_valid
  end
end
