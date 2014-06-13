#include <queue>
#include <set>
#include <vector>
#include <pair>
#include <string.h> //memcmp

unsigned int board[5][4] =
{
   //0, 1, 2, 3
    {1, 2, 2, 3}, //0
    {1, 2, 2, 3}, //1
    {4, 5, 5, 6}, //2
    {4, 7, 8, 6}, //3
    {9, 0, 0, 10},//4
}

const unsigned int ROW = 5;
const unsigned int COL = 4;
const unsigned int BLOCKS = 10;

enum Shape
{
    Invalid = 0,
    Vertical,
    Horizontal,
    Square,
    Single
}

class Mask;

class Block
{
public:
    Block(Shape shape, int left, int top) : m_shape(shape), m_left(left), m_top(top) {}
    virtual ~Block() {}

    Shape GetShape() { return m_shape; }
    int GetLeft() { return m_left; }
    int GetTop() { return m_top; }
    int GetBottom()
    {
        unsigned int mask[] = {0, 1, 0, 1, 0};
        return m_top + mask[static_cast<int>(m_shape)];
    }

    int GetRight()
    {
        unsigned int mask[] = {0, 0, 1, 1, 0};
        return m_left + mask[static_cast<int>(m_shape)];
    }

    void Print()
    {
        m_mask.Print();
    }

    void mask(int value, Mask* mask);
private:
    Shape m_shape;

    int left;
    int top;

};

class Mask
{
public:
    Mask()
    {
        memset(m_board, 0, sizeof(board));
    }
    virtual ~Mask () {}

    void Set(int value, int left, int top)
    {
        //TODO:
    }

    bool IsEmpty(int left, int top)
    {
        //TODO: assert
    }

    void Print()
    {
        int i = 0; i < ROW; ++i)
        {
            for (int j = 0; j < COL; ++j)
            {
                printf(" %c",  m_board[i][j] + '0');
            }
            printf("\n");
        }
    }

    unsigned int m_board[ROW][COL];
};

Struct CompMask
{
    bool operator() (const Mast& lhs, const Mask& rhs) const
    {
        memcmp(lhs.m_board, rhs.m_board, sizeof(board));
    }
};

class State
{
public:
    State() { m_step = 0; }
    virtual ~State ();

    bool IsSolved()
    {
        Block cc = m_blocks[1];
        return cc.GetLeft() == 1 and cc.GetTop() == 3;
    }

    Mask ToMask()
    {
        Mask temp;
        for (i = 0; i < 10; i++)
        {
            m_blocks[i].mask(static_cast<int>(m_blocks[i].m_shape), &temp);
        }
        return temp;
    }

    std::vector<State> Moves()
    {
        //up
        //down
        //left
        //right
    }

    void Print()
    {
        for (i = 0; i < 10; i++)
        {
            m_blocks[i].Print();
        }
    }

    Block m_blocks[BLOCKS];
    int m_step;
};

int main(int argc, const char *argv[])
{
    std::queue<State> queue;
    std::set<Mask, CompMask> seen;

    State initState;
    initState.m_blocks[0] = Block(Shape::Vertical, 0, 0);
    initState.m_blocks[1] = Block(Shape::Square,   1, 0);
    initState.m_blocks[2] = Block(Shape::Vertical, 3, 0);
    initState.m_blocks[3] = Block(Shape::Vertical, 0, 2);
    initState.m_blocks[4] = Block(Shape::Horizontal, 1, 2);
    initState.m_blocks[5] = Block(Shape::Vertical, 3, 2);
    initState.m_blocks[6] = Block(Shape::Single,   0, 4);
    initState.m_blocks[7] = Block(Shape::Single,   1, 3);
    initState.m_blocks[8] = Block(Shape::Single,   2, 3);
    initState.m_blocks[9] = Block(Shape::Single,   3, 4);

    queue.push_back(initState);
    seen.insert(initState.ToMask());

    while(!queue.empty())
    {
        State currentState = queue.front();
        queue.pop();

        if (currentState.IsSolved())
        {
            currentState.Print();
            return;
        }

        if (currentState.m_step > 200)
        {
            return;
        }

        std::vector<State> nexts = currentState.Moves();
        std::vector<State>::iterator it = nexts.begin();
        for (; it != nexts.end(); ++it)
        {
            std::pair<std::set<State>::iterator, bool> ret = seen.insert((*it).ToMask());
            if (ret.second)
            {
                queue.push_back(*it);
            }
        }
    }

    return 0;
}
