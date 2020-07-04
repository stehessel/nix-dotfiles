import pdb


class Config(pdb.DefaultConfig):
    def setup(self, pdb):
        print('Use "emb" to enter IPython shell')
