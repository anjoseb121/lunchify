# frozen_string_literal: true

def load_fixture(folder, file)
  File.read(Rails.root.join('spec', 'fixtures', folder, "#{file}.json"))
end
