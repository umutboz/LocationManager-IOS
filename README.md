# LocationManager-IOS
OneframeMobile Location Manager IOS Example

first step 

plese run

```ruby
pod install

```


```ruby
import LocationManager

```

```ruby
LocationManager.setLocationListenIsRecursive(isRecursive: true)
        LocationManager.setLocationUpdateTimeLimit(seconds: 5)
        LocationManager.setLocationAccuracy(meters: 10)
        LocationManager.getCurrentLocationWithProgress(progress: { (latitude, longitude, accuracy, locationObj) in
            //En iyi location değeri yakalındığında bu blok çalışır(birden fazla çalışabilir)
            print("lat:\(latitude) long : \(longitude) accuracy : \(accuracy)")
            
        }, onComplete: { (lat, long, acc,locationObj ) in
            //Belirlenen süre tamamlandığında bu blok çalışır
            print ("distance from to :uskudar \(locationObj.dinstanceInKm(otherLocationLatitudee: 41.018944, otherLocationLongitude: 29.057631)) km")
            print("Called when update timer expires  lat:\(lat) long : \(long) accuracy : \(acc)")
            self.count -= 1
            if self.count == 0{
                LocationManager.setLocationListenIsRecursive(isRecursive: false)
            }
        }) { (error) in
            //Called on failure
            print("Called on failure\n lat:\(error)")
            
        }
```
