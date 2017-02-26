#include <stdio.h>
#include <stdlib.h>

/* 
Tictactoe : un tictactoe avec une IA
 */

/*  La structure de donnée  */

typedef struct gamestate {
  int** cases;
    int firstToPlay;
    int note;
    int ended;
} gamestate;

/*  Un Mouvement  */

typedef struct move {
  int x;
    int y;
} move;

/*  On affiche l'état  */


void print_state(struct gamestate * g) {
    int y, x;
    printf("\n|");
    for (y = 0; y < 3; y++)
    {
        for (x = 0; x < 3; x++)
        {
            if (g->cases[x][y] == 0)
                printf(" ");
            else if (g->cases[x][y] == 1)
                printf("O");
            else
                printf("X");
            printf("|");
        }
        if (y != 2)
            printf("\n|-|-|-|\n|");
    }
    printf("\n");
}

/*  On dit qui gagne (info stoquées dans g.ended et g.note )  */


void eval0(struct gamestate * g) {
    int y, x;
    int win = 0;
    int freecase = 0;
    for (y = 0; y < 3; y++)
    {
        int col = -1;
        int lin = -1;
        for (x = 0; x < 3; x++)
        {
            if (g->cases[x][y] == 0)
                freecase++;
            int colv = g->cases[x][y];
            int linv = g->cases[y][x];
            if (col == -1 && colv != 0)
                col = colv;
            else if (colv != col)
                col = -2;
            if (lin == -1 && linv != 0)
                lin = linv;
            else if (linv != lin)
                lin = -2;
        }
        if (col >= 0)
            win = col;
        else if (lin >= 0)
            win = lin;
    }
    for (x = 1; x < 3; x++)
    {
        if (g->cases[0][0] == x && g->cases[1][1] == x && g->cases[2][2] == x)
            win = x;
        if (g->cases[0][2] == x && g->cases[1][1] == x && g->cases[2][0] == x)
            win = x;
    }
    g->ended = win != 0 || freecase == 0;
    if (win == 1)
        g->note = 1000;
    else if (win == 2)
        g->note = -1000;
    else
        g->note = 0;
}

/*  On applique un mouvement  */


void apply_move_xy(int x, int y, struct gamestate * g) {
    int player = 2;
    if (g->firstToPlay)
        player = 1;
    g->cases[x][y] = player;
    g->firstToPlay = !g->firstToPlay;
}


void apply_move(struct move * m, struct gamestate * g) {
    apply_move_xy(m->x, m->y, g);
}


void cancel_move_xy(int x, int y, struct gamestate * g) {
    g->cases[x][y] = 0;
    g->firstToPlay = !g->firstToPlay;
    g->ended = 0;
}


void cancel_move(struct move * m, struct gamestate * g) {
    cancel_move_xy(m->x, m->y, g);
}


int can_move_xy(int x, int y, struct gamestate * g) {
    return g->cases[x][y] == 0;
}


int can_move(struct move * m, struct gamestate * g) {
    return can_move_xy(m->x, m->y, g);
}

/* 
Un minimax classique, renvoie la note du plateau
 */


int minmax(struct gamestate * g) {
    int x, y;
    eval0(g);
    if (g->ended)
        return g->note;
    int maxNote = -10000;
    if (!g->firstToPlay)
        maxNote = 10000;
    for (x = 0; x < 3; x++)
        for (y = 0; y < 3; y++)
            if (can_move_xy(x, y, g))
            {
                apply_move_xy(x, y, g);
                int currentNote = minmax(g);
                cancel_move_xy(x, y, g);
                /* Minimum ou Maximum selon le coté ou l'on joue*/
                if (currentNote > maxNote == g->firstToPlay)
                    maxNote = currentNote;
            }
    return maxNote;
}

/* 
Renvoie le coup de l'IA
 */


struct move * play(struct gamestate * g) {
    int x, y;
    struct move * minMove = malloc(sizeof(move));
    minMove->x = 0;
    minMove->y = 0;
    int minNote = 10000;
    for (x = 0; x < 3; x++)
        for (y = 0; y < 3; y++)
            if (can_move_xy(x, y, g))
            {
                apply_move_xy(x, y, g);
                int currentNote = minmax(g);
                printf("%d, %d, %d\n", x, y, currentNote);
                cancel_move_xy(x, y, g);
                if (currentNote < minNote)
                {
                    minNote = currentNote;
                    minMove->x = x;
                    minMove->y = y;
                }
            }
    printf("%d%d\n", minMove->x, minMove->y);
    return minMove;
}


struct gamestate * init0() {
    int i, j;
    int* *cases = calloc(3, sizeof(int*));
    for (i = 0; i < 3; i++)
    {
        int *tab = calloc(3, sizeof(int));
        for (j = 0; j < 3; j++)
            tab[j] = 0;
        cases[i] = tab;
    }
    struct gamestate * a = malloc(sizeof(gamestate));
    a->cases = cases;
    a->firstToPlay = 1;
    a->note = 0;
    a->ended = 0;
    return a;
}


struct move * read_move() {
    int y, x;
    scanf("%d %d ", &x, &y);
    struct move * b = malloc(sizeof(move));
    b->x = x;
    b->y = y;
    return b;
}
int main(void) {
    int i;
    for (i = 0; i < 2; i++)
    {
        struct gamestate * state = init0();
        struct move * c = malloc(sizeof(move));
        c->x = 1;
        c->y = 1;
        apply_move(c, state);
        struct move * d = malloc(sizeof(move));
        d->x = 0;
        d->y = 0;
        apply_move(d, state);
        while (!state->ended)
        {
            print_state(state);
            apply_move(play(state), state);
            eval0(state);
            print_state(state);
            if (!state->ended)
            {
                apply_move(play(state), state);
                eval0(state);
            }
        }
        print_state(state);
        printf("%d\n", state->note);
    }
    return 0;
}


