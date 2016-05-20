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
CS_prod = linspace(0,0,CS); % array to store the ID of the producers of cached packets
CS_freshness = linspace(0,0,CS); % array to store the freshness of cached packets
cache_hit = 0;
cache_miss = 0;
for t = 1:100 % simulation for 3 minutes
    cons = randi(M); % select a consumer randomly, uniformly distributed
    prod = randi(N); % select a producer randomly, uniformly distributed
    freshness = randi([Fmin, Fmax]); % select a freshness value randomly, uniformly distributed
    index = find(CS_prod == prod); % check if a cached entry from the selected producer exists in cache
    if not(isempty(index)) % if such an entry is found
        if(CS_freshness(index) <= freshness)
            cache_hit = cache_hit + 1; % cache hit
        else % the packet is stale
            cache_miss = cache_miss + 1; % cache miss, fetch freshest packet from producer
            CS_freshness(index) = 0;
        end
    else
        cache_miss = cache_miss + 1; % cache miss, fetch from producer
        index = find(CS_prod == 0); % check if there is a free space
        if not(isempty(index)) % an empty space exists in cache
            CS_prod(index(1)) = prod;
            CS_freshness(index(1)) = 0;
        else
        index = find(CS_freshness == max(CS_freshness)); % find the oldest entry
        CS_prod(index(1)) = prod; % replace the oldest entry with the fetched entry
        CS_freshness(index(1)) = 0;
        end
    end
    S = [num2str(cons), ' ', num2str(prod), ' packet IDs = ', num2str(CS_prod), ' packet freshness = ', num2str(CS_freshness)];
    disp(S);
    CS_freshness = CS_freshness + 1;
end
fprintf('Cache hits = %d, cache misses = %d\n', cache_hit, cache_miss);