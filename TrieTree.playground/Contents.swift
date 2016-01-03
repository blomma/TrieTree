//: Playground - noun: a place where people can play

class TrieNode<T: Hashable> {
    var Values : Set<T>
    var Children : Dictionary<Character, TrieNode>

    init () {
        Values = Set()
        Children = Dictionary<Character, TrieNode>()
    }

    func IsLeaf() -> Bool {
        return Children.count == 0
    }

    func IsTerminater() -> Bool {
        return Values.count != 0
    }

    func AddOrGetChild(key: Character) -> TrieNode {
        if let child = Children[key] {
            return child
        }

        let child = TrieNode()
        Children[key] = child

        return child
    }

    func PrefixMatches() -> [T] {
        if IsLeaf() {
            return IsTerminater() ? [T](Values) : [T]()
        } else {
            var values = Array<T>()
            if IsTerminater() {
                values.appendContentsOf(Values)
            }


            for (_, node) in Children {
                values.appendContentsOf(node.PrefixMatches())
            }

            return values
        }
    }
}

class Trie<T: Hashable> {
    private var rootNode: TrieNode<T>

    init() {
        rootNode = TrieNode()
    }

    func AddWord(term: String, value: T) {
        var childNode = rootNode

        for(_, key) in term.characters.enumerate() {
            childNode = childNode.AddOrGetChild(key)
        }

        childNode.Values.insert(value)
    }

    func GetNode(term: String) -> TrieNode<T>? {
        var childNode = rootNode

        for(_, char) in term.characters.enumerate() {
            if let child = childNode.Children[char] {
                childNode = child
            } else {
                return nil
            }
        }

        return childNode
    }
}

var t = Trie<String>()
t.AddWord("Test", value: "hej")
t.AddWord("Tester", value: "fan")

var n = t.GetNode("")
n?.Children.count
n?.PrefixMatches()
