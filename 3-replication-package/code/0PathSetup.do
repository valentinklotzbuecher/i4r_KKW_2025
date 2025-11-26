////////////////////////////////////////////////////////////VK
global folder "C:\Users\VK\Sync\Research\i4r_amsterdam_2025\3-replication-package"
set varabbrev off, permanently
version 16.0

// global folder "/Users/lingbo/Desktop/3-replication-package"
////////////////////////////////////////////////////////////VK

global seed 12345

// Installing Packages

// net install grc1leg2.pkg, from (http://digital.cgdev.org/doc/stata/MO/Misc/) replace
// ssc install estout, replace
// ssc install moremata, replace
// ssc install mhtreg, replace


////////////////////////////////////////////////////////////VK
do $folder/code/1DataClean_Spectator.do
do $folder/code/1DataClean_Worker.do
////////////////////////////////////////////////////////////VK

do $folder/code/spectator_main.do
do $folder/code/spectator_vary.do
do $folder/code/worker_main.do