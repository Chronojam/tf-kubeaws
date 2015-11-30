# Certificate Authority Generation
cd ca/
./root-ca.sh
cd ../


# Controller Generation
# Only Support 1 at the moment, dont try multiple because it wont work.
for ADDR in "10.0.0.50"
do
  cd api-server/
  ./api-server.sh $ADDR
  cd ../
done

# Worker Generation
# Eventually You'll be able to pass multiple ip's here, but for now we're just gonna do this.
# If you want multiple workers, just add the ip addresses here, and update the _worker_instances terraform file.
for ADDR in "10.0.0.60" "10.0.0.61"
do
  cd worker/
  ./worker.sh $ADDR
  cd ../
done
