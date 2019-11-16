-----------------------------------------------
Instructions pour la r�plication et l'extension
-----------------------------------------------

Ces fichiers produisent une r�plication de l'article de Steffen(2017) ainsi qu'une extension
� l'aide d'un appariement par score de propension. 

Chaque fichier .m est annot� avec le d�tail des diff�rentes �tapes et une explication compl�te
est fournie dans le rapport PDF remis.

Pour ex�cuter la r�plication, ouvrir et ex�cuter le fichier replication.m.

Pour ex�cuter l'extension, ouvrir et ex�cuter le fichier extension.m.

Note: Dans les deux cas, l'emploi de l'option ''Publish'' de Matlab est recommand� plut�t que simplement
''Run'' puisque les graphiques et tableaux sont pr�sent�s dans l'ordre.

----------------
1. replication.m
----------------

Lorsqu�ex�cut�, ce fichier produit une r�plication des deux sections de l'article de Steffen(2017).

Pour la portion d'analyse descriptive, les graphiques produits par matlab sont sur la gauche et ceux
de l'article sont sur la droite pour comparaison.

Pour la portion analyse par r�gression, les r�sultats obtenus avec matlab sont pr�sent�s suivis 
des tableaux de l'article pour comparaison.

------------
2. extension.m
------------

Lorsqu�ex�cut�, ce fichier effectue un appariement par score de propension. 

Les trois outputs sont un vecteur des scores de propension, un graphique de la r�gion de
support commun, un tableau de test de diff�rence des moyennes et un effet de traitement.

Note: l'effet de traitement change � chaque ex�cution puisque la variable �tudi�e (le taux d'int�r�t)
est g�n�r�e al�atoirement.

------------
3. logit.m
------------
La fonction logit.m et ses composantes sont employ� dans la r�plication et l'extension, mais n'ont
pas � �tre ex�cut� directement. Plus d'instruction sur l'usage de la fonction sont disponible en 
commentaires dans le fichier logit.m
