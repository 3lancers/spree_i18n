shared_context "behaves as translatable" do
  context "when there's a missing translation" do
    before do
      subject.name = "English"
      I18n.locale = :es
    end

    it "falls back to default locale" do
      subject.name.should == "English"
    end
  end

  context "missing translation on default locale" do
    let!(:model) { subject.class.new(name: 'produto') }

    before do
      SpreeI18n::Config.supported_locales [:en, :es]
      I18n.locale = :es
    end

    it "falls back to not default translations" do
      I18n.locale = :en
      model.name.should == "produto"
    end
  end
end
