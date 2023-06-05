#include <iostream>
#include <stack>
#include <climits>
using namespace std;

struct Node {
    int data;
    Node* left;
    Node* right;
};

class BST {
private:
    Node* root;

    Node* createNode(int value) {
        Node* newNode = new Node();
        newNode->data = value;
        newNode->left = newNode->right = nullptr;
        return newNode;
    }

    Node* insertRecursive(Node* root, int value) {
        if (root == nullptr) {
            root = createNode(value);
            return root;
        }

        if (value < root->data) {
            root->left = insertRecursive(root->left, value);
        } else if (value > root->data) {
            root->right = insertRecursive(root->right, value);
        }

        return root;
    }

    void inorderTraversal(Node* root) {
        if (root == nullptr) {
            return;
        }

        inorderTraversal(root->left);
        cout << root->data << " ";
        inorderTraversal(root->right);
    }

    int findHeightRecursive(Node* root) {
        if (root == nullptr) {
            return 0;
        }

        int leftHeight = findHeightRecursive(root->left);
        int rightHeight = findHeightRecursive(root->right);

        return max(leftHeight, rightHeight) + 1;
    }

    Node* swapPointers(Node* root) {
        if (root == nullptr) {
            return nullptr;
        }

        Node* temp = root->left;
        root->left = root->right;
        root->right = temp;

        swapPointers(root->left);
        swapPointers(root->right);

        return root;
    }

    Node* searchValue(Node* root, int value) {
        if (root == nullptr || root->data == value) {
            return root;
        }

        if (value < root->data) {
            return searchValue(root->left, value);
        } else {
            return searchValue(root->right, value);
        }
    }

public:
    BST() {
        root = nullptr;
    }

    void insert(int value) {
        root = insertRecursive(root, value);
    }

    void displayInorder() {
        inorderTraversal(root);
        cout << endl;
    }

    int findLongestPath() {
        return findHeightRecursive(root);
    }

    int findMinimumValue() {
        Node* current = root;
        while (current->left != nullptr) {
            current = current->left;
        }
        return current->data;
    }

    void swapPointers() {
        root = swapPointers(root);
    }

    bool search(int value) {
        Node* result = searchValue(root, value);
        return (result != nullptr);
    }
    
    int findMaxValue() {
        if (root == nullptr) {
            return INT_MIN;
        }

        stack<Node*> nodeStack;
        Node* current = root;
        int maxValue = INT_MIN;

        while (current != nullptr || !nodeStack.empty()) {
            while (current != nullptr) {
                nodeStack.push(current);
                current = current->left;
            }

            current = nodeStack.top();
            nodeStack.pop();

            maxValue = max(maxValue, current->data);

            current = current->right;
        }

        return maxValue;
    }
};

int main() {
    BST bst;

    // Constructing the binary search tree
    bst.insert(5);
    bst.insert(3);
    bst.insert(7);
    bst.insert(2);
    bst.insert(4);
    bst.insert(6);
    bst.insert(8);

    // Insert a new node
    bst.insert(1);

    // Inorder traversal
    cout << "Inorder Traversal: ";
    bst.displayInorder();

    // Longest path from root
    int longestPath = bst.findLongestPath();
    cout << "Number of nodes in the longest path from root: " << longestPath << endl;

    // Minimum value in the tree
    int minValue = bst.findMinimumValue();
    cout << "Minimum data value: " << minValue << endl;

    // Swap left and right pointers
    bst.swapPointers();
    cout << "Inorder Traversal after swapping pointers: ";
    bst.displayInorder();

    // Search for a value
    int valueToSearch = 6;
    bool found = bst.search(valueToSearch);
    if (found) {
        cout << "Value " << valueToSearch << " found in the tree." << endl;
    } else {
        cout << "Value " << valueToSearch << " not found in the tree." << endl;
    }

    // Find the maximum value
    int maxValue = bst.findMaxValue();
    cout << "Maximum data value: " << maxValue << endl;

    return 0;
}
