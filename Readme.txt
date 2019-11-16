-----------------------------------------------
Instructions pour la réplication et l'extension
-----------------------------------------------

Ces fichiers produisent une réplication de l'article de Steffen(2017) ainsi qu'une extension
à l'aide d'un appariement par score de propension. 

Chaque fichier .m est annoté avec le détail des différentes étapes et une explication complète
est fournie dans le rapport PDF remis.

Pour exécuter la réplication, ouvrir et exécuter le fichier replication.m.

Pour exécuter l'extension, ouvrir et exécuter le fichier extension.m.

Note: Dans les deux cas, l'emploi de l'option ''Publish'' de Matlab est recommandé plutôt que simplement
''Run'' puisque les graphiques et tableaux sont présentés dans l'ordre.

----------------
1. replication.m
----------------

Lorsqu’exécuté, ce fichier produit une réplication des deux sections de l'article de Steffen(2017).

Pour la portion d'analyse descriptive, les graphiques produits par matlab sont sur la gauche et ceux
de l'article sont sur la droite pour comparaison.

Pour la portion analyse par régression, les résultats obtenus avec matlab sont présentés suivis 
des tableaux de l'article pour comparaison.

------------
2. extension.m
------------

Lorsqu’exécuté, ce fichier effectue un appariement par score de propension. 

Les trois outputs sont un vecteur des scores de propension, un graphique de la région de
support commun, un tableau de test de différence des moyennes et un effet de traitement.

Note: l'effet de traitement change à chaque exécution puisque la variable étudiée (le taux d'intérêt)
est générée aléatoirement.

------------
3. logit.m
------------
La fonction logit.m et ses composantes sont employé dans la réplication et l'extension, mais n'ont
pas à être exécuté directement. Plus d'instruction sur l'usage de la fonction sont disponible en 
commentaires dans le fichier logit.m
