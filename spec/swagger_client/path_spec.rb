describe SwaggerClient::Path do
  let(:path) { described_class.new "foo", /\Afoo\z/ }

  describe ".new" do
    subject { path }

    its(:name)   { is_expected.to eq "foo" }
    its(:regexp) { is_expected.to eq(/\Afoo\z/) }
  end

  describe "#subpath" do
    before  { path.add_subpath("foo/{id}", /\A\d+\z/) }
    subject { path.subpath(part) }

    context 'with valid part' do
      let(:part) { 134 }

      it { is_expected.to be_kind_of described_class }
      its(:name) { is_expected.to eq 'foo/{id}' }
    end

    context 'with invalid part' do
      let(:part) { 'bar' }

      it 'fails' do
        expect { subject }.to raise_error SwaggerClient::PathError, %r{ foo/bar }
      end
    end
  end
end
