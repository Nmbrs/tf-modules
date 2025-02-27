��#   S q l   S e r v e r   m o d u l e  
  
 # #   S u m m a r y  
  
 T h e   ` s q l _ s e r v e r `   m o d u l e   p r o v i d e s   a   c o m p r e h e n s i v e   T e r r a f o r m   s o l u t i o n   f o r   s e t t i n g   u p   S Q L   d a t a b a s e .  
 T h i s   m o d u l e   s t r e a m l i n e s   t h e   p r o c e s s   o f   c r e a t i n g   a n d   c o n f i g u r i n g   S Q L   S e r v e r s .   I t   h a n d l e s   e s s e n t i a l   t a s k s   s u c h   a s   p r o v i s i o n i n g   t h e   n e c e s s a r y   i n f r a s t r u c t u r e ,   d e f i n i n g   d e p l o y m e n t   c o n f i g u r a t i o n s ,   a n d   e s t a b l i s h i n g   p l a t f o r m - s p e c i f i c   s e t t i n g s .   B y   a b s t r a c t i n g   t h e s e   c o m p l e x i t i e s ,   t h e   m o d u l e   e n s u r e s   c o n s i s t e n t   a n d   e f f i c i e n t   d e p l o y m e n t   o f   w e b   a p p s ,   r e g a r d l e s s   o f   t h e   u n d e r l y i n g   o p e r a t i n g   s y s t e m .  
  
  
 # #   R e q u i r e m e n t s  
  
 |   N a m e   |   V e r s i o n   |  
 | - - - - - - | - - - - - - - - - |  
 |   < a   n a m e = " r e q u i r e m e n t _ t e r r a f o r m " > < / a >   [ t e r r a f o r m ] ( # r e q u i r e m e n t \ _ t e r r a f o r m )   |   > =   1 . 5 . 0 ,   <   2 . 0 . 0   |  
 |   < a   n a m e = " r e q u i r e m e n t _ a z u r e r m " > < / a >   [ a z u r e r m ] ( # r e q u i r e m e n t \ _ a z u r e r m )   |   ~ >   3 . 7 0   |  
  
 # #   P r o v i d e r s  
  
 |   N a m e   |   V e r s i o n   |  
 | - - - - - - | - - - - - - - - - |  
 |   < a   n a m e = " p r o v i d e r _ a z u r e a d " > < / a >   [ a z u r e a d ] ( # p r o v i d e r \ _ a z u r e a d )   |   2 . 4 7 . 0   |  
 |   < a   n a m e = " p r o v i d e r _ a z u r e r m " > < / a >   [ a z u r e r m ] ( # p r o v i d e r \ _ a z u r e r m )   |   3 . 9 8 . 0   |  
  
 # #   M o d u l e s  
  
 N o   m o d u l e s .  
  
 # #   R e s o u r c e s  
  
 |   N a m e   |   T y p e   |  
 | - - - - - - | - - - - - - |  
 |   [ a z u r e r m _ m s s q l _ s e r v e r . s q l _ s e r v e r ] ( h t t p s : / / r e g i s t r y . t e r r a f o r m . i o / p r o v i d e r s / h a s h i c o r p / a z u r e r m / l a t e s t / d o c s / r e s o u r c e s / m s s q l _ s e r v e r )   |   r e s o u r c e   |  
 |   [ a z u r e r m _ m s s q l _ s e r v e r _ e x t e n d e d _ a u d i t i n g _ p o l i c y . s q l _ a u d i t i n g ] ( h t t p s : / / r e g i s t r y . t e r r a f o r m . i o / p r o v i d e r s / h a s h i c o r p / a z u r e r m / l a t e s t / d o c s / r e s o u r c e s / m s s q l _ s e r v e r _ e x t e n d e d _ a u d i t i n g _ p o l i c y )   |   r e s o u r c e   |  
 |   [ a z u r e r m _ m s s q l _ v i r t u a l _ n e t w o r k _ r u l e . s q l _ s e r v e r _ n e t w o r k _ r u l e ] ( h t t p s : / / r e g i s t r y . t e r r a f o r m . i o / p r o v i d e r s / h a s h i c o r p / a z u r e r m / l a t e s t / d o c s / r e s o u r c e s / m s s q l _ v i r t u a l _ n e t w o r k _ r u l e )   |   r e s o u r c e   |  
 |   [ a z u r e a d _ g r o u p . a z u r e a d _ s q l _ a d m i n ] ( h t t p s : / / r e g i s t r y . t e r r a f o r m . i o / p r o v i d e r s / h a s h i c o r p / a z u r e a d / l a t e s t / d o c s / d a t a - s o u r c e s / g r o u p )   |   d a t a   s o u r c e   |  
 |   [ a z u r e r m _ k e y _ v a u l t . k e y _ v a u l t _ l o c a l _ s q l _ a d m i n ] ( h t t p s : / / r e g i s t r y . t e r r a f o r m . i o / p r o v i d e r s / h a s h i c o r p / a z u r e r m / l a t e s t / d o c s / d a t a - s o u r c e s / k e y _ v a u l t )   |   d a t a   s o u r c e   |  
 |   [ a z u r e r m _ k e y _ v a u l t _ s e c r e t . l o c a l _ s q l _ a d m i n _ p a s s w o r d ] ( h t t p s : / / r e g i s t r y . t e r r a f o r m . i o / p r o v i d e r s / h a s h i c o r p / a z u r e r m / l a t e s t / d o c s / d a t a - s o u r c e s / k e y _ v a u l t _ s e c r e t )   |   d a t a   s o u r c e   |  
 |   [ a z u r e r m _ s t o r a g e _ a c c o u n t . a u d i t i n g _ s t o r a g e _ a c c o u n t ] ( h t t p s : / / r e g i s t r y . t e r r a f o r m . i o / p r o v i d e r s / h a s h i c o r p / a z u r e r m / l a t e s t / d o c s / d a t a - s o u r c e s / s t o r a g e _ a c c o u n t )   |   d a t a   s o u r c e   |  
 |   [ a z u r e r m _ s u b n e t . s u b n e t ] ( h t t p s : / / r e g i s t r y . t e r r a f o r m . i o / p r o v i d e r s / h a s h i c o r p / a z u r e r m / l a t e s t / d o c s / d a t a - s o u r c e s / s u b n e t )   |   d a t a   s o u r c e   |  
  
 # #   I n p u t s  
  
 |   N a m e   |   D e s c r i p t i o n   |   T y p e   |   D e f a u l t   |   R e q u i r e d   |  
 | - - - - - - | - - - - - - - - - - - - - | - - - - - - | - - - - - - - - - | : - - - - - - - - : |  
 |   < a   n a m e = " i n p u t _ a l l o w e d _ s u b n e t s " > < / a >   [ a l l o w e d \ _ s u b n e t s ] ( # i n p u t \ _ a l l o w e d \ _ s u b n e t s )   |   A   m a p   o f   s u b n e t s   a n d   t h e i r   c o r r e s p o n d i n g   r e s o u r c e   g r o u p s   t h a t   w i l l   b e   a l l o w e d   t o   c o n n e c t   t o   t h e   s e r v e r .   |   < p r e > l i s t ( o b j e c t ( { < b r >         s u b n e t _ r e s o u r c e _ g r o u p _ n a m e   =   s t r i n g < b r >         v i r t u a l _ n e t w o r k _ n a m e               =   s t r i n g < b r >         s u b n e t _ n a m e                                 =   s t r i n g < b r >     } ) ) < / p r e >   |   n / a   |   y e s   |  
 |   < a   n a m e = " i n p u t _ a z u r e a d _ a u t h e n t i c a t i o n _ o n l y _ e n a b l e d " > < / a >   [ a z u r e a d \ _ a u t h e n t i c a t i o n \ _ o n l y \ _ e n a b l e d ] ( # i n p u t \ _ a z u r e a d \ _ a u t h e n t i c a t i o n \ _ o n l y \ _ e n a b l e d )   |   S p e c i f i e s   i f   o n l y   A z u r e   A D   a u t h e n t i c a t i o n   i s   a l l o w e d   |   ` b o o l `   |   ` t r u e `   |   n o   |  
 |   < a   n a m e = " i n p u t _ a z u r e a d _ s q l _ a d m i n " > < / a >   [ a z u r e a d \ _ s q l \ _ a d m i n ] ( # i n p u t \ _ a z u r e a d \ _ s q l \ _ a d m i n )   |   T h e   n a m e   o f   t h e   a d m i n   ( A z u r e   A D )   t h a t   w i l l   b e   S Q L   S e r v e r   a d m i n   |   ` s t r i n g `   |   n / a   |   y e s   |  
 |   < a   n a m e = " i n p u t _ c o u n t r y " > < / a >   [ c o u n t r y ] ( # i n p u t \ _ c o u n t r y )   |   S p e c i f i e s   t h e   c o u n t r y   f o r   t h e   a p p   s e r v i c e s   a n d   s e r v i c e   p l a n   n a m e s .   |   ` s t r i n g `   |   n / a   |   y e s   |  
 |   < a   n a m e = " i n p u t _ e n v i r o n m e n t " > < / a >   [ e n v i r o n m e n t ] ( # i n p u t \ _ e n v i r o n m e n t )   |   D e f i n e s   t h e   e n v i r o n m e n t   t o   p r o v i s i o n   t h e   r e s o u r c e s .   |   ` s t r i n g `   |   n / a   |   y e s   |  
 |   < a   n a m e = " i n p u t _ l o c a l _ s q l _ a d m i n " > < / a >   [ l o c a l \ _ s q l \ _ a d m i n ] ( # i n p u t \ _ l o c a l \ _ s q l \ _ a d m i n )   |   T h e   n a m e   o f   t h e   S Q L   S e r v e r   a d m i n   t o   b e   c r e a t e d   l o c a l y   i n   t h e   S Q L   s e r v e r   |   ` s t r i n g `   |   ` " " `   |   n o   |  
 |   < a   n a m e = " i n p u t _ l o c a l _ s q l _ a d m i n _ k e y _ v a u l t " > < / a >   [ l o c a l \ _ s q l \ _ a d m i n \ _ k e y \ _ v a u l t ] ( # i n p u t \ _ l o c a l \ _ s q l \ _ a d m i n \ _ k e y \ _ v a u l t )   |   T h e   n a m e   o f   t h e   k e y   v a u l t   w h e r e   t h e   l o c a l   S Q L   S e r v e r   a d m i n   p a s s w o r d   i s   s t o r e d   |   < p r e > l i s t ( o b j e c t ( { < b r >         k e y _ v a u l t _ n a m e                       =   s t r i n g < b r >         k e y _ v a u l t _ r e s o u r c e _ g r o u p   =   s t r i n g < b r >     } ) ) < / p r e >   |   n / a   |   y e s   |  
 |   < a   n a m e = " i n p u t _ l o c a l _ s q l _ a d m i n _ k e y _ v a u l t _ s e c r e t _ n a m e " > < / a >   [ l o c a l \ _ s q l \ _ a d m i n \ _ k e y \ _ v a u l t \ _ s e c r e t \ _ n a m e ] ( # i n p u t \ _ l o c a l \ _ s q l \ _ a d m i n \ _ k e y \ _ v a u l t \ _ s e c r e t \ _ n a m e )   |   T h e   n a m e   o f   t h e   s e c r e t   i n   t h e   k e y   v a u l t   t h a t   c o n t a i n s   t h e   l o c a l   S Q L   S e r v e r   a d m i n   p a s s w o r d   |   ` s t r i n g `   |   n / a   |   y e s   |  
 |   < a   n a m e = " i n p u t _ l o c a t i o n " > < / a >   [ l o c a t i o n ] ( # i n p u t \ _ l o c a t i o n )   |   T h e   l o c a t i o n   w h e r e   t h e   S Q L   S e r v e r   w i l l   b e   c r e a t e d   |   ` s t r i n g `   |   n / a   |   y e s   |  
 |   < a   n a m e = " i n p u t _ n o d e _ n u m b e r " > < / a >   [ n o d e \ _ n u m b e r ] ( # i n p u t \ _ n o d e \ _ n u m b e r )   |   S p e c i f i e s   t h e   n o d e   n u m b e r   f o r   t h e   r e s o u r c e s .   |   ` n u m b e r `   |   n / a   |   y e s   |  
 |   < a   n a m e = " i n p u t _ r e s o u r c e _ g r o u p _ n a m e " > < / a >   [ r e s o u r c e \ _ g r o u p \ _ n a m e ] ( # i n p u t \ _ r e s o u r c e \ _ g r o u p \ _ n a m e )   |   T h e   n a m e   o f   t h e   r e s o u r c e   g r o u p   t o   c r e a t e   t h e   S Q L   S e r v e r   i n   |   ` s t r i n g `   |   n / a   |   y e s   |  
 |   < a   n a m e = " i n p u t _ s t o r a g e _ a c c o u n t _ a u d i t i n g " > < / a >   [ s t o r a g e \ _ a c c o u n t \ _ a u d i t i n g ] ( # i n p u t \ _ s t o r a g e \ _ a c c o u n t \ _ a u d i t i n g )   |   T h e   n a m e   o f   t h e   s t o r a g e   a c c o u n t   t o   u s e   f o r   a u d i t i n g   |   ` s t r i n g `   |   n / a   |   y e s   |  
 |   < a   n a m e = " i n p u t _ s t o r a g e _ a c c o u n t _ r e s o u r c e _ g r o u p " > < / a >   [ s t o r a g e \ _ a c c o u n t \ _ r e s o u r c e \ _ g r o u p ] ( # i n p u t \ _ s t o r a g e \ _ a c c o u n t \ _ r e s o u r c e \ _ g r o u p )   |   T h e   n a m e   o f   t h e   r e s o u r c e   g r o u p   i n   w h i c h   t h e   s t o r a g e   a c c o u n t   o f   a u d i t i n g   e x i s t s .   |   ` s t r i n g `   |   n / a   |   y e s   |  
 |   < a   n a m e = " i n p u t _ w o r k l o a d " > < / a >   [ w o r k l o a d ] ( # i n p u t \ _ w o r k l o a d )   |   T h e   n a m e   o f   t h e   S Q L   S e r v e r   t h a t   w i l l   b e   c r e a t e d   |   ` s t r i n g `   |   n / a   |   y e s   |  
  
 # #   O u t p u t s  
  
 |   N a m e   |   D e s c r i p t i o n   |  
 | - - - - - - | - - - - - - - - - - - - - |  
 |   < a   n a m e = " o u t p u t _ s q l _ s e r v e r _ f q d n " > < / a >   [ s q l \ _ s e r v e r \ _ f q d n ] ( # o u t p u t \ _ s q l \ _ s e r v e r \ _ f q d n )   |   n / a   |  
 |   < a   n a m e = " o u t p u t _ s q l _ s e r v e r _ i d " > < / a >   [ s q l \ _ s e r v e r \ _ i d ] ( # o u t p u t \ _ s q l \ _ s e r v e r \ _ i d )   |   n / a   |  
 |   < a   n a m e = " o u t p u t _ s q l _ s e r v e r _ n a m e " > < / a >   [ s q l \ _ s e r v e r \ _ n a m e ] ( # o u t p u t \ _ s q l \ _ s e r v e r \ _ n a m e )   |   n / a   |  
  
 # #   H o w   t o   u s e   i t ?    
  
 A   n u m b e r   o f   c o d e   s n i p p e t s   d e m o n s t r a t i n g   d i f f e r e n t   u s e   c a s e s   f o r   t h e   m o d u l e   h a v e   b e e n   i n c l u d e d   t o   h e l p   y o u   u n d e r s t a n d   h o w   t o   u s e   t h e   m o d u l e   i n   T e r r a f o r m .  
  
 # #   S Q L   S e r v c e r   w i t h   p u b l i c   a c c e s s   d i s a b l e d  
  
 ` ` ` h c l  
 m o d u l e   " s q l _ s e r v e r "   {  
     s o u r c e                             =   " g i t : : g i t h u b . c o m / N m b r s / t f - m o d u l e s / / a z u r e / s q l _ s e r v e r "  
     w o r k l o a d                         =   " s q l s e r v e r n a m e "  
     r e s o u r c e _ g r o u p _ n a m e   =   " r e s o u r c e g r o u p s q l s e r v e r "  
     e n v i r o n m e n t                   =   " d e v "  
     l o c a t i o n                         =   " w e s t e u r o p e "  
     l o c a l _ s q l _ a d m i n _ s e t t i n g s   =   {  
         l o c a l _ s q l _ a d m i n                     =   " s q l a d m i n g r o u p "  
         k e y _ v a u l t _ n a m e                       =   " k v - a l l m y p a s s w o r d s "  
         k e y _ v a u l t _ r e s o u r c e _ g r o u p   =   " r g - m y s e c r e t s "  
         k e y _ v a u l t _ s e c r e t _ n a m e         =   " s q l - a d m i n - p a s s w o r d "  
     }  
     p u b l i c _ n e t w o r k _ s e t t i n g s   =   {  
         a c c e s s _ e n a b l e d     =   f a l s e  
         a l l o w e d _ s u b n e t s   =   [ ]  
     }  
 }  
 ` ` `  
  
 # #   S Q L   S e r v c e r   w i t h   p u b l i c   a c c e s s   e n a b l e d  
  
 ` ` ` h c l  
 m o d u l e   " s q l _ s e r v e r "   {  
     s o u r c e                             =   " g i t : : g i t h u b . c o m / N m b r s / t f - m o d u l e s / / a z u r e / s q l _ s e r v e r "  
     w o r k l o a d                         =   " s q l s e r v e r n a m e "  
     r e s o u r c e _ g r o u p _ n a m e   =   " r e s o u r c e g r o u p s q l s e r v e r "  
     e n v i r o n m e n t                   =   " d e v "  
     l o c a t i o n                         =   " w e s t e u r o p e "  
     l o c a l _ s q l _ a d m i n _ s e t t i n g s   =   {  
         l o c a l _ s q l _ a d m i n                     =   " s q l a d m i n g r o u p "  
         k e y _ v a u l t _ n a m e                       =   " k v - a l l m y p a s s w o r d s "  
         k e y _ v a u l t _ r e s o u r c e _ g r o u p   =   " r g - m y s e c r e t s "  
         k e y _ v a u l t _ s e c r e t _ n a m e         =   " s q l - a d m i n - p a s s w o r d "  
     }  
     p u b l i c _ n e t w o r k _ s e t t i n g s   =   {  
         a c c e s s _ e n a b l e d     =   t r u e  
         a l l o w e d _ s u b n e t s   =   [  
             {  
                 s u b n e t _ r e s o u r c e _ g r o u p _ n a m e   =   " s u b n e t _ r g "  
                 v i r t u a l _ n e t w o r k _ n a m e               =   " v n e t _ n a m e "  
                 s u b n e t _ n a m e                                 =   " s u b n e t _ n a m e "  
             } ,  
             {  
                 s u b n e t _ r e s o u r c e _ g r o u p _ n a m e   =   " s u b n e t _ r g 2 "  
                 v i r t u a l _ n e t w o r k _ n a m e               =   " v n e t _ n a m e 2 "  
                 s u b n e t _ n a m e                                 =   " s u b n e t _ n a m e 2 "  
             } ,  
             {  
                 s u b n e t _ r e s o u r c e _ g r o u p _ n a m e   =   " s u b n e t _ r g 3 "  
                 v i r t u a l _ n e t w o r k _ n a m e               =   " v n e t _ n a m e 3 "  
                 s u b n e t _ n a m e                                 =   " s u b n e t _ n a m e 3 "  
             } ,  
         ]  
     }  
 }  
 ` ` `  
 