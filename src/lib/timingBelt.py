##
##
##  Tento skript urci optimalni vzdalenost remenic pro zadany pomerem
##  delku remene a velikost mensiho kola.
##
##
##


import math

belt_T5 = {
    'p': 5,    # belt pitch
    'u': 0.5, # pitch differential
    'H': 2.2, # Belt height
    'h': 1.2, # tooth height
}



##
##          NASTAVENI
##

belt = belt_T5
belt['l'] = 420
ratio = 5.2

pulley_small = 15

## Konec nastaveni
pulley_big = int(pulley_small*ratio)
pulley_small_d = pulley_small*belt['p']/math.pi
pulley_big_d = pulley_big*belt['p']/math.pi

Y = (belt['l'] - math.pi*(pulley_small_d + pulley_big_d)/2)/2
C = math.sqrt( Y**2 - ((pulley_big_d/2 - pulley_small_d/2)**2))

if C < (pulley_small*belt['p']/math.pi/2 + pulley_big*belt['p']/math.pi/2):
    print("Moc velky pomer....")
    print("!!!!!!!!!!!!!!")

print("Kola s pomerem 1:{} maji {} a {} zubu".format(pulley_big/pulley_small, pulley_small, pulley_big))
print("Vzdalenost remenic je {}".format(C))
print("Prumery remenic jsou {} a {}".format(pulley_small_d, pulley_big_d))
print("Prumery remenic jsou {} a {}".format(pulley_small_d-belt['u']*2, pulley_big_d-belt['u']*2))
print("Polomery jsou {} a {}".format(pulley_small_d/2-belt['u'], pulley_big_d/2-belt['u']))
print("mezera mezi koly je {}".format(C-pulley_big_d/2-pulley_small_d/2))
