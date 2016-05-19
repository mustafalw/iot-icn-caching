% The following script simulates an IoT scenario having M consumers (or
% requesters) requesting sensor data from one of the N sensors. It is
% assumed that the sensors are connected a router wirelessly and the
% consumers are in turn connected to the router through a wired connection.
% The aim is to analyze the performance of the caching policy implemented
% at the router.
M = 5; % number of consumers
N = 5; % number of producers
CS = 3; % size of cache store
Fmin = 15; % strictest freshness requirement
Fmax = 20; % most relaxed freshness requirement
CS_prod = zeroes(CS); % array store the ID of the producers of cached packets
CS_freshness = zeroes(CS); % array store the freshness of cached packets
for t = 1:180 % simulation for 3 minutes
    cons = randi(M); % select a consumer randomly, uniformly distributed
    prod = randi(N); % select a producer randomly, uniformly distributed
    freshness = randi([Fmin, Fmax]); % select a freshness value randomly, uniformly distributed
    
end
