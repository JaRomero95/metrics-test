import {useTranslation} from 'react-i18next';
import DefaultLayout from 'components/DefaultLayout';
import Home from 'pages/Home';

function App() {
  const {t} = useTranslation();

  return (
    <DefaultLayout title={t('title')}>
      <Home />
    </DefaultLayout>
  );
}

export default App;
