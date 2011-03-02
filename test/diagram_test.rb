require 'shoulda'
require 'umlify'

class DiagramTest < Test::Unit::TestCase

  context "Diagram" do

    setup do
      @diagram = Umlify::Diagram.new
    end

    should "respond to create"  do
      assert_respond_to @diagram, :create
    end

    should "add Strings statements to diagram"  do
      test_statement = '[foo]->[bar]'
      @diagram.create do
        add test_statement
      end

      assert_equal ['[foo]->[bar]'], @diagram.statements
    end

    should "add UmlClass without associations to diagrams"  do
      test_uml_class = Umlify::UmlClass.new 'Unicorn'
      test_uml_class.variables << 'foo_variable'
      test_uml_class.methods << 'bar_method'

      @diagram.create do
        add test_uml_class
      end

      assert @diagram.statements.include? '[Unicorn|foo_variable|bar_method]'
    end

    should "add UmlClass with associations to diagrams"  do
      test_uml_class = Umlify::UmlClass.new 'Unicorn'
      test_uml_class.variables << 'foo_variable'
      test_uml_class.methods << 'bar_method'
      test_uml_class.associations['foo'] = 'Bar'
      test_uml_class.associations['chunky'] = 'Bacon'

      @diagram.create do
        add test_uml_class
      end

      assert @diagram.statements.include? '[Unicorn|foo_variable|bar_method]'
      assert @diagram.statements.include? '[Unicorn]-foo>[Bar]'
      assert @diagram.statements.include? '[Unicorn]-chunky>[Bacon]'
    end

    should "export th yUML html"  do
      test_uml_class = Umlify::UmlClass.new 'Unicorn'
      test_uml_class.variables << 'foo_variable'
      test_uml_class.methods << 'bar_method'

      @diagram.create do
        add test_uml_class
      end

      assert_equal '<img src="http://yuml.me/diagram/class/[Unicorn|foo_variable|bar_method]" />',
       @diagram.export
    end

  end
end

