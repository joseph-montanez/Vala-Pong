#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#include "darkcore.h"
#include "generate.h"

dc_world world;

void obj_on_key_press(struct dc_object *self) {
    int mx, my;
    mx = 0;
    my = 0;
    //printf("Before: %ix%i\n", mx, my);
    
    if (world.keys_pressed.up == 1) {
        my = 8;
    }
    if (world.keys_pressed.down == 1) {
        my = -8;
    }
    if (world.keys_pressed.left == 1) {
        mx = -8;
    }
    if (world.keys_pressed.right == 1) {
        mx = 8;
    }
    
    dc_point_2d player_pos;
    player_pos.x = self->x + 16 + mx, 
    player_pos.y = self->y + 16 + my;
    dc_point_2d player_tile_pos = dc_tile_get_position(player_pos);
    
    printf("After 1: %ix%i\n", mx, my);

    int px = player_tile_pos.x;
    int py = player_tile_pos.y;
    
    //-- Top Row
    int tmptiles[2][9];
    tmptiles[0][0] = px - 1;
    tmptiles[0][1] = py - 1;
    tmptiles[1][0] = px;
    tmptiles[1][1] = py - 1;
    tmptiles[2][0] = px + 1;
    tmptiles[2][1] = py - 1;
    //-- Center Row
    tmptiles[3][0] = px - 1;
    tmptiles[3][1] = py;
    tmptiles[4][0] = px;
    tmptiles[4][1] = py;
    tmptiles[5][0] = px + 1;
    tmptiles[5][1] = py;
    //-- Bottom Row
    tmptiles[6][0] = px - 1;
    tmptiles[6][1] = py + 1;
    tmptiles[7][0] = px;
    tmptiles[7][1] = py + 1;
    tmptiles[8][0] = px + 1;
    tmptiles[8][1] = py + 1;
    
    printf("After 2: %ix%i\n", mx, my);

    if (my != 0) {
        dc_object_set_y(self, dc_object_get_y(self) + my);
    }
    
    if (mx != 0) {
        dc_object_set_x(self, dc_object_get_x(self) + mx);
    }
    
    /*
    if (mx != 0 || my != 0) {
        int x = mx;
        int y = my;
        //printf("After: %ix%i\n", mx, my);
        
        dc_point_2d player_pos;
        player_pos.x = self->x + 16 + x, 
        player_pos.y = self->y + 16 + y;
        dc_point_2d player_tile_pos = dc_tile_get_position(player_pos);
        printf("PLayer Pos: [%i, %i]\n", self->x + x, self->y + y);
        printf("PLayer Tile Pos: [%i, %i]\n\n", player_tile_pos.x, player_tile_pos.y);
        
        //printf("After 2: %ix%i\n", mx, my);
        
        //-- Top Row
        int tmptiles[2][9];
        tmptiles[0][0] = px - 1;
        tmptiles[0][1] = py - 1;
        tmptiles[1][0] = px;
        tmptiles[1][1] = py - 1;
        tmptiles[2][0] = px + 1;
        tmptiles[2][1] = py - 1;
        //-- Center Row
        tmptiles[3][0] = px - 1;
        tmptiles[3][1] = py;
        tmptiles[4][0] = px;
        tmptiles[4][1] = py;
        tmptiles[5][0] = px + 1;
        tmptiles[5][1] = py;
        //-- Bottom Row
        tmptiles[6][0] = px - 1;
        tmptiles[6][1] = py + 1;
        tmptiles[7][0] = px;
        tmptiles[7][1] = py + 1;
        tmptiles[8][0] = px + 1;
        tmptiles[8][1] = py + 1;

        //-- If remove this mx and my get all fucked up...
        mx = x;
        my = y;
        
        int tid;
        printf("Player Pos: %i x %i", player_pos.x, player_pos.y);

        dc_bounding_box player_box = dc_get_bounding_box(player_pos, 15);
        //printf("Pre-Pre-Move: %ix%i\n", mx, my);
        for (tid = 0; tid < 9; tid++) {
            int tile[2];
            tile[0] = tmptiles[tid][0];
            tile[1] = tmptiles[tid][1];
            
            if (tile[0] < 0 || tile[1] < 0 || tile[0] >= map_max_x || tile[1] >= map_max_x) {
                //printf("Tile out of bounds %i, %i\n", tile[0], tile[1]);
                continue;
            }
            
            int tile_id = world.map[tile[0]][tile[1]][0];
            printf("tile_id: %i - ", tile_id);
            //printf("Tile Position: %ix%i\n", tile[0], tile[1]);
            
            // half since it based on the center of the tile
            dc_point_2d tile_pos;
            tile_pos.x = tile[0] * 32;
            tile_pos.y = tile[1] * 32;
            dc_bounding_box tile_box = dc_get_bounding_box(tile_pos, 16); 
            
            int is_hit = dc_collision_box_in_box(player_box, tile_box);
            printf("\n%i hit \npx %i py %i pw %i ph %i\n", is_hit,
                player_box.x,player_box.y,player_box.width,player_box.height);
            printf("\n%i hit \ntx %i ty %i tw %i th %i\n", is_hit,
                tile_box.x,tile_box.y,tile_box.width,tile_box.height);
            
            if (is_hit == 1) {
                dc_tile *world_tiles = world.tiles;
                
                if (tile_id < 0 || tile_id >= world.tiles_size) {
                    //printf("Tile out of bounds\n");
                    continue;
                }
                printf("tileid: %i\n", tile_id);
                if (world_tiles[tile_id].blocked == 1) {
                    printf("Tile is blocked\n");
                    mx = 0;
                    my = 0;
                    break;
                }
            }
            
            //printf("Pre-Move: %ix%i\n", mx, my);
        }
        
        //printf("Move: %ix%i\n", mx, my);
    }
    */
}

int main() {
    // Start the Dark Core Reactor!    
    dc_init(640, 480);

    world = dc_world_create();
    world = generate_map(world);
    printf("World Map: %i\n", world.map[1][0][0]);
    
    dc_object obj = dc_object_create();
    dc_object_set_x(&obj, 64);
    dc_object_set_y(&obj, 64);
    dc_object_set_on_key_press(&obj, obj_on_key_press);
    
    dc_world_add_object(&world, &obj);
    
    // Load the texture
    struct dc_texture tex;
    dc_texture_create(&tex, "resources/grass-tiles-2-small.png");
    dc_world_add_texture(&world, &tex);
    
    // Map tiles to texture
    dc_tile t1, t2, t3;
    dc_texture_map(&t1, "Grass", 0, 0, 6, 2, 0);
    dc_world_add_tile(&world, &t1);
    dc_texture_map(&t2, "Grass", 5, 0, 6, 2, 0);
    dc_world_add_tile(&world, &t2);
    dc_texture_map(&t3, "Dirt", 4, 0, 6, 2, 1);
    dc_world_add_tile(&world, &t3);
    
    dc_run(&world);
            
    dc_texture_destory(&tex);

    return 0;
}
