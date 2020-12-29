

# -*- coding: utf-8 -*-
"""
Created on Mon Apr 27 00:35:00 2020

@author: Abhinav
"""
#Import Libraries----------
import pandas as pd 
from apyori import apriori

#Module "apyori" may not be available by default in our Python library.
#hence, we have have to install it separately in Anaconda Powershell/Command Prompt window.
#the cmd for installing this module is:"pip install apyori".

#Importing Dataset
dataset = pd.read_csv('F:/pyWork/pyData/MBA_Basic.csv', header = None)

#Now, Convert Pandas DataFrame into a list of lists.
transactions = []
for i in range(0, 7501):
    transactions.append([str(dataset.values[i,j]) for j in range(0, 20)])
    
#Build the Apriori model.[]
rules = apriori(transactions, min_support = 0.03, min_confidence = 0.2, min_lift = 1)
r= list(rules)

#Total no. of rules
len(r)

#Print rules:
print(r)

from pandas import DataFrame
df = DataFrame(r,columns=['Itemsets','Support','Lift','Confidence','Others-Confi & Lift'])







