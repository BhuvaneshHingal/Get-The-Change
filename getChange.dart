var cache = new Map();

void main() {

    print("""
     XXX       XX       XXX     XXXX
      X   X    X    X     X    X      X
       X   X    XXXX      XXX        X
        XXX      X    X      X   X      X
      """.replaceAll('X','_/')); // prints "DART" in 3D.

    print("#==================================================================#");

    var stopwatch = new Stopwatch()..start();

    // use the brute-force recursion for the small problem
    int amount = 100;
    list coinTypes = [20,10,5,2,1];
    print ("\nThere are "+coins(amount,coinTypes).toString() + " ways for ₹$amount/- using $coinTypes coins.");

    // use the cache version for the big problem
    amount = 100000;
    coinTypes = [100,50,20,10,5,1];
    print ("\nSimilarly, there are "+cachedCoins(amount,coinTypes).toString() + " ways for ₹$amount/- using $coinTypes coins.");

    stopwatch.stop();
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    print ("\t\t... completed in " + (stopwatch.elapsedMilliseconds/1000).toString() + " seconds");
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
}


coins(int amount, list coinTypes) {
    int count = 0;

    if(coinTypes.length == 1) return (1);   // just coins available, so only one way to make change

    for(int i=0; i<=(amount/coinTypes[0]).toInt(); i++){                // brute force recursion
      count += coins(amount-(i*coinTypes[0]),coinTypes.sublist(1));     // sublist(1): This method returns a new list containing elements from index between start and end .
    }

    print("there is/are " + count.toString() +" way/ways to count change for ${amount.toString()} using ${coinTypes} coins.");
    print("x-----------------------------------------------------------------x");
    return(count);
  }


  cachedCoins(int amount, list coinTypes) {
      int count = 0;

      // this is more efficient, looks at last two coins.  but not fast enough.

      if(coinTypes.length == 2) return ((amount/coinTypes[0]).toInt() + 1);

      var key = "$amount.$coinTypes";         // like "100.[20,10,5,2,1]"
      var cacheValue = cache[key];            // Review to see if we've seen this before

      if(cacheValue != null) return(cacheValue);

      count = 0;
      // same recursion as simple method, but caches all subqueries too
      for(int i=0; i<=(amount/coinTypes[0]).toInt(); i++){
        count += cachedCoins(amount-(i*coinTypes[0]),coinTypes.sublist(1));     // sublist(1): This method returns a new list containing elements from index between start and end .
      }

      cache[key] = count;                     // add this to the cache
      return(count);
    }
