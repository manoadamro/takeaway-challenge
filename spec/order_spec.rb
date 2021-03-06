require './lib/order.rb'

describe Order do

  let(:basket) { double(:basket, add_item: nil, show_basket: nil, items: {}, formatted_total: "") }
  let(:menu) { double(:menu, add_item: nil, item_count: 1, get_dish: { name: 'dish', price: 1 }) }
  subject { Order.new(menu, basket) }

  describe '.select_dish' do
    context 'method call' do
      specify {
        expect(subject).to respond_to(:select_dish)
      }
    end

    context 'calls get_dish' do
      specify {
        expect(menu).to receive(:get_dish)
        subject.select_dish(0)
      }
    end

    context 'adds item to basket' do
      specify {
        expect(basket).to receive(:add_item)
        subject.select_dish(0)
      }
    end
  end

  describe '.complete' do
    context 'method call' do
      specify {
        expect(subject).to respond_to(:complete)
      }
    end
    context 'returns summary' do
      specify {
        expect(subject.complete).to be_a(Hash)
      }
    end
  end

  describe '.summary' do
    context 'uses items' do
      specify {
        expect(basket).to receive(:items)
        subject.send(:summary, "time")
      }
    end

    context 'uses total' do
      specify {
        expect(basket).to receive(:formatted_total)
        subject.send(:summary, "time")
      }
    end

    context 'contains time' do
      specify {
        summary = subject.send(:summary, 'time')
        expect(summary[:time]).to eq('time')
      }
    end
  end

  describe '.item_count' do
    context 'method call' do
      specify {
        expect(subject).to respond_to(:item_count)
      }
    end

    context 'accurate count' do
      specify {
        expect(basket).to receive(:items)
        subject.item_count
      }
    end
  end

  describe '.show' do
    context 'method call' do
      specify {
        expect(subject).to respond_to(:show)
      }
    end

    context 'shows basket' do
      specify {
        expect(basket).to receive(:show_basket)
        subject.send(:show)
      }
    end
  end
end
