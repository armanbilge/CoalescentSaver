//
//  Config.h
//
//  CoalescentSaver
//  A Mac screensaver derived from Trevor Bedford's coaltrace
//      <https://github.com/trvrb/coaltrace>
//
//  Copyright (C) 2014 Arman D. Bilge <armanbilge@gmail.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#define TWODIMEN false
#define MUTATION true
#define TRACING true
#define DYNAMICS true
#define STATISTICS false
#define HELP false
#define FRATE false
#define BLACKBG true
#define BRANCHCOLORING true

#define CHARGE 200
#define MAXVEL 4.0
#define MAXRAD 6
#define BASELINE 25
#define WALLMULTIPLIER 20
#define TRACEDEPTH 100//20
#define PUSHBACK 0.75
#define LINEWIDTH 3.0

#if BLACKBG
#define BG 0.0
#define OUTLINE 1.0
#else
#define BG 1.0
#define OUTLINE 0.0
#endif

#define N 12
#define MU 0.1
#define GEN 60.0

#define INDHUE 0.95
#define LOOPING true

#define FRAMERATE 60.0
