require 'lru_cache.rb'

describe 'LRUCache' do
    let(:newlru) {LRUCache.new(4)}

    describe '#initialize'do
        it 'should initialize an empty array.' do |variable|
            expect(newlru.store).to be_empty    
        end
        
        it 'should set a length attribute equal to the passed in integer.' do
          expect(newlru.size).to eq(4)
        end
    end

    describe '#add' do
      it 'should add an element to the end of the cache.' do
        newlru.add(3)
        newlru.add(5)
        expect(newlru.store.size).to be(2)
        expect(newlru.store.last).to be(5)
      end

      it 'should not extend the length of the store past the specified length.' do
        newlru.add(3)
        newlru.add(2)
        newlru.add('cat')
        newlru.add(4)
        newlru.add(9)
        expect(newlru.store.length).to eq(newlru.size)
      end

      it 'should eliminate the least recently used items from the list first.' do
        newlru.add(3)
        newlru.add(2)
        newlru.add('cat')
        newlru.add(4)
        newlru.add(9)
        expect(newlru.store).not_to include(3)
      end

      it 'should replace an item already in the list by eliminating it and adding it to the end.' do
        newlru.add(3)
        newlru.add(2)
        newlru.add('cat')
        newlru.add(4)
        newlru.add(3)
        expect(newlru.store).to eq([2, 'cat', 4, 3])
      end
    end


    describe '#count' do
      it 'should return the number of elements currently in the cache.' do
        newlru.add(3)
        expect(newlru.count).to eq(1)
      end
    end

    describe '#show' do
      it 'should display all items currently in the cache.' do
        newlru.add(2)
        newlru.add('cat')
        newlru.add(4)
        newlru.add(3)
        expect(newlru.show).to eq([2, 'cat', 4, 3])
      end
    end

end