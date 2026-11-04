/*! \file HDSPeConf.h
 *! \brief Global functions. 
 * Philippe.Bekaert@uhasselt.be - 20210907,15,16 */

#pragma once

#include <sys/types.h>

//! \brief Post a callback function.
extern void PostCB(std::function<void(void)> cb);

#define POSTCB(cb,prop) [this](){ PostCB([this](){ cb(); }); }

// Data directory for resources like icons - can be overridden at compile time with -DDATADIR
#ifndef DATADIR
#define DATADIR "./"
#endif

// Path to the warning icon
#define WARNING_ICON_PATH DATADIR "dialog-warning.png"
